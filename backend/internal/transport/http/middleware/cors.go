package middleware

import (
	"net/http"
	"strings"
)

// CorsMiddleware checks incoming Origin headers and sets access control headers appropriately.
func CorsMiddleware(allowedOrigin string, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		origin := r.Header.Get("Origin")
		if origin != "" {
			// Check if incoming origin matches the configured FrontendURL, localhost, 127.0.0.1, or LAN IPs on Vite dev port 5173
			isAllowed := origin == allowedOrigin ||
				origin == "http://localhost:5173" ||
				origin == "http://127.0.0.1:5173" ||
				(strings.HasPrefix(origin, "http://192.168.") && strings.HasSuffix(origin, ":5173")) ||
				(strings.HasPrefix(origin, "http://10.") && strings.HasSuffix(origin, ":5173")) ||
				(strings.HasPrefix(origin, "http://172.") && strings.HasSuffix(origin, ":5173"))

			if isAllowed {
				w.Header().Set("Access-Control-Allow-Origin", origin)
				w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, DELETE")
				w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization, X-Requested-With")
				w.Header().Set("Access-Control-Max-Age", "86400") // 24 hours
			}
		}

		// Handle preflight OPTIONS requests directly
		if r.Method == http.MethodOptions {
			w.WriteHeader(http.StatusNoContent)
			return
		}

		next.ServeHTTP(w, r)
	})
}
