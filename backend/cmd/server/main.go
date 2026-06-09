package main

import (
	"encoding/json"
	"log"
	"net"
	"net/http"
	"time"

	"nodestrike/backend/internal/app/config"
	"nodestrike/backend/internal/transport/http/middleware"
)

// HealthResponse defines the contract for /health response
type HealthResponse struct {
	Status      string `json:"status"`
	Service     string `json:"service"`
	Environment string `json:"environment"`
}

func main() {
	// Load application configuration
	cfg := config.Load()

	// Initialize the Standard Library ServeMux (HTTP Router)
	// Go 1.22+ supports HTTP method matching directly in the pattern (e.g. "GET /path")
	mux := http.NewServeMux()

	// Register the health check endpoint
	mux.HandleFunc("GET /health", func(w http.ResponseWriter, r *http.Request) {
		// Log incoming health checks
		log.Printf("[HTTP] %s %s - Agent: %s - IP: %s", r.Method, r.URL.Path, r.UserAgent(), r.RemoteAddr)

		w.Header().Set("Content-Type", "application/json")
		
		res := HealthResponse{
			Status:      "ok",
			Service:     "nodestrike-backend",
			Environment: cfg.AppEnv,
		}

		if err := json.NewEncoder(w).Encode(res); err != nil {
			log.Printf("[ERROR] Failed to write health response: %v", err)
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}
	})

	// Attach CORS middleware
	var handler http.Handler = mux
	handler = middleware.CorsMiddleware(cfg.FrontendURL, handler)

	// Combine host and port safely
	addr := net.JoinHostPort(cfg.ServerHost, cfg.ServerPort)

	// Log server details on start
	log.Printf("[SERVER] Initializing %s...", cfg.AppName)
	log.Printf("[SERVER] Environment: %s", cfg.AppEnv)
	log.Printf("[SERVER] Configured Host/Port: %s", addr)
	log.Printf("[SERVER] Configured Frontend URL (CORS allowed): %s", cfg.FrontendURL)
	log.Printf("[SERVER] Listening at http://%s", addr)

	// Configure HTTP server settings
	server := &http.Server{
		Addr:         addr,
		Handler:      handler,
		ReadTimeout:  15 * time.Second,
		WriteTimeout: 15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	// Start server execution
	if err := server.ListenAndServe(); err != nil {
		log.Fatalf("[FATAL] Server execution failed: %v", err)
	}
}
