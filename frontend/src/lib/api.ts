export type ConnectionState = 'checking' | 'online' | 'offline' | 'error';

export interface HealthCheckResult {
  state: ConnectionState;
  service?: string;
  environment?: string;
  latency?: number;
  error?: string;
}

const BACKEND_URL = import.meta.env.VITE_BACKEND_URL || 'http://localhost:8080';

/**
 * Pings the backend health endpoint, measuring the response time (latency).
 * Uses an AbortController to implement a connection timeout.
 */
export async function checkBackendHealth(): Promise<HealthCheckResult> {
  const startTime = performance.now();
  
  try {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 4000); // 4-second timeout limit

    const response = await fetch(`${BACKEND_URL}/health`, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
      },
      signal: controller.signal,
    });

    clearTimeout(timeoutId);
    
    const endTime = performance.now();
    const latency = Math.round(endTime - startTime);

    if (!response.ok) {
      return {
        state: 'error',
        error: `HTTP HTTP ${response.status}: ${response.statusText}`,
        latency,
      };
    }

    const data = await response.json();
    
    if (data && data.status === 'ok') {
      return {
        state: 'online',
        service: data.service,
        environment: data.environment,
        latency,
      };
    }

    return {
      state: 'error',
      error: 'Invalid server response structure',
      latency,
    };

  } catch (err: any) {
    const endTime = performance.now();
    const latency = Math.round(endTime - startTime);

    if (err.name === 'AbortError') {
      return {
        state: 'offline',
        error: 'Connection timed out',
        latency,
      };
    }

    return {
      state: 'offline',
      error: err.message || 'Network connection failed',
      latency,
    };
  }
}
