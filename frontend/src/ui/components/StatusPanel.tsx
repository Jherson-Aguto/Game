import { useEffect, useState, useCallback } from 'react';
import { checkBackendHealth } from '../../lib/api';
import type { HealthCheckResult } from '../../lib/api';

export default function StatusPanel() {
  const [result, setResult] = useState<HealthCheckResult>({
    state: 'checking',
  });
  const [isUpdating, setIsUpdating] = useState(false);

  // Core checking routine
  const performCheck = useCallback(async () => {
    setIsUpdating(true);
    const checkResult = await checkBackendHealth();
    setResult(checkResult);
    
    // Maintain brief update animation state
    setTimeout(() => {
      setIsUpdating(false);
    }, 450);
  }, []);

  useEffect(() => {
    // Initial connection attempt
    performCheck();

    // Setup periodic server status polling (every 5 seconds)
    const intervalId = setInterval(performCheck, 5000);

    return () => clearInterval(intervalId);
  }, [performCheck]);

  // Map state enum into localized user-facing UI labels and theme classes
  const getStateDetails = () => {
    switch (result.state) {
      case 'checking':
        return {
          label: 'DIAGNOSTIC IN PROGRESS',
          colorClass: 'state-checking',
          description: 'Scanning interface links to authoritative server...',
        };
      case 'online':
        return {
          label: 'SECURED // ONLINE',
          colorClass: 'state-online',
          description: 'Data handshake completed. System is operational.',
        };
      case 'offline':
        return {
          label: 'DISCONNECTED // OFFLINE',
          colorClass: 'state-offline',
          description: 'Connection lost. Host is currently unreachable.',
        };
      case 'error':
        return {
          label: 'HANDSHAKE FAILED // ERROR',
          colorClass: 'state-error',
          description: 'Host reached, but protocol parameters mismatch.',
        };
    }
  };

  const statusInfo = getStateDetails();
  const backendUrl = import.meta.env.VITE_BACKEND_URL || 'http://localhost:8080';

  return (
    <div className={`cyber-panel ${result.state}`}>
      {/* Corner indicators for cyberpunk aesthetic */}
      <div className="cyber-corner top-left"></div>
      <div className="cyber-corner top-right"></div>
      <div className="cyber-corner bottom-left"></div>
      <div className="cyber-corner bottom-right"></div>

      <div className="cyber-header">
        <span className="cyber-title">ARENA PROTOCOL STATUS</span>
        <span className="cyber-code">STRIKE_SYS_CHECK // V1.0</span>
      </div>

      <div className="cyber-body">
        <div className="status-indicator-row">
          <div className={`status-dot ${statusInfo.colorClass} ${isUpdating ? 'syncing' : ''}`}></div>
          <div className="status-text-block">
            <h3 className="status-label">{statusInfo.label}</h3>
            <p className="status-description">{statusInfo.description}</p>
          </div>
        </div>

        <div className="cyber-divider"></div>

        <div className="metadata-grid">
          <div className="metadata-item">
            <span className="meta-label">NODE ENDPOINT</span>
            <span className="meta-value font-mono">{backendUrl}</span>
          </div>
          <div className="metadata-item">
            <span className="meta-label">SERVICE IDENTIFIER</span>
            <span className="meta-value">{result.service || 'N/A'}</span>
          </div>
          <div className="metadata-item">
            <span className="meta-label">ENVIRONMENT</span>
            <span className="meta-value font-mono uppercase">{result.environment || 'N/A'}</span>
          </div>
          <div className="metadata-item">
            <span className="meta-label">LATENCY</span>
            <span className={`meta-value font-mono ${result.latency !== undefined ? 'highlight' : ''}`}>
              {result.latency !== undefined ? `${result.latency}ms` : 'N/A'}
            </span>
          </div>
        </div>

        {result.error && (
          <div className="cyber-error-box">
            <div className="error-title">DIAGNOSTIC CORE LOG:</div>
            <div className="error-message">{result.error}</div>
          </div>
        )}
      </div>

      <div className="cyber-footer">
        <button
          type="button"
          className={`cyber-button ${isUpdating ? 'loading' : ''}`}
          onClick={performCheck}
          disabled={isUpdating}
        >
          <span className="button-text">
            {isUpdating ? 'SYNCHRONIZING...' : 'PING PROTOCOL CORE'}
          </span>
        </button>
      </div>
    </div>
  );
}
