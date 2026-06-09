package config

import (
	"bufio"
	"os"
	"path/filepath"
	"strings"
)

// Config holds the application configuration loaded from environment variables
type Config struct {
	AppName     string
	AppEnv      string
	ServerHost  string
	ServerPort  string
	FrontendURL string
}

// Load loads the environment variables (parsing .env if present) and returns the Config struct
func Load() *Config {
	loadEnvFile()

	return &Config{
		AppName:     getEnv("APP_NAME", "NODESTRIKE"),
		AppEnv:      getEnv("APP_ENV", "development"),
		ServerHost:  getEnv("SERVER_HOST", "0.0.0.0"),
		ServerPort:  getEnv("SERVER_PORT", "8080"),
		FrontendURL: getEnv("FRONTEND_URL", "http://localhost:5173"),
	}
}

// getEnv gets an environment variable or returns a fallback value
func getEnv(key, fallback string) string {
	if val := os.Getenv(key); val != "" {
		return val
	}
	return fallback
}

// loadEnvFile searches for a .env file and sets the environment variables
func loadEnvFile() {
	paths := []string{
		".env",
		"../.env",
		"../../.env",
	}

	for _, path := range paths {
		absPath, err := filepath.Abs(path)
		if err != nil {
			continue
		}
		file, err := os.Open(absPath)
		if err != nil {
			continue
		}
		defer file.Close()

		scanner := bufio.NewScanner(file)
		for scanner.Scan() {
			line := strings.TrimSpace(scanner.Text())
			if line == "" || strings.HasPrefix(line, "#") {
				continue
			}

			parts := strings.SplitN(line, "=", 2)
			if len(parts) != 2 {
				continue
			}

			key := strings.TrimSpace(parts[0])
			value := strings.TrimSpace(parts[1])

			// Strip quotes if present
			if (strings.HasPrefix(value, "\"") && strings.HasSuffix(value, "\"")) ||
				(strings.HasPrefix(value, "'") && strings.HasSuffix(value, "'")) {
				value = value[1 : len(value)-1]
			}

			// Only set if not already set in environment
			if os.Getenv(key) == "" {
				os.Setenv(key, value)
			}
		}
		if err := scanner.Err(); err != nil {
			// Silently ignore scanner read errors as fallback configurations exist
		}
		break // Stop after successfully reading the first found .env file
	}
}
