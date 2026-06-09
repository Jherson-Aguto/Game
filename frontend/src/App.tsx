import StatusPanel from './ui/components/StatusPanel'
import './App.css'

function App() {
  return (
    <div className="arena-dashboard">
      <header className="dashboard-header">
        <div className="logo-container">
          <div className="logo-glow"></div>
          <h1 className="logo-text">NODE<span className="accent-text">STRIKE</span></h1>
        </div>
        <div className="system-indicator">
          <span className="sys-status-badge">ARENA DEPLOYMENT</span>
          <span className="sys-version">V0.1.0 // PRE-ALPHA</span>
        </div>
      </header>

      <main className="dashboard-content">
        <div className="dashboard-grid">
          <div className="main-panel-section">
            <StatusPanel />
          </div>
          
          <div className="info-panel-section">
            <div className="cyber-card">
              <div className="card-header">
                <h4>ARENA PROTOCOL OVERVIEW</h4>
              </div>
              <div className="card-body">
                <p>
                  Welcome to <strong>NODESTRIKE: Arena Protocol</strong>. This dashboard represents 
                  the core operations interface for verifying local server node health.
                </p>
                <div className="bullet-points">
                  <div className="bullet-item">
                    <span className="bullet-icon">▸</span>
                    <span><strong>Phase 1:</strong> Establishing standard health check & CORS policy (Active).</span>
                  </div>
                  <div className="bullet-item">
                    <span className="bullet-icon">▸</span>
                    <span><strong>Phase 2:</strong> Matchmaking and real-time state synchronization via WebSocket (Pending).</span>
                  </div>
                  <div className="bullet-item">
                    <span className="bullet-icon">▸</span>
                    <span><strong>Phase 3:</strong> 3D Combat simulation inside WebGL combat rooms (Scheduled).</span>
                  </div>
                </div>
              </div>
            </div>
            
            <div className="cyber-card console-card">
              <div className="card-header">
                <h4>DIAGNOSTIC TERMINAL</h4>
              </div>
              <div className="card-body console-body font-mono">
                <div className="console-line text-dim">&gt; Initializing systems connection...</div>
                <div className="console-line text-dim">&gt; Fetching status from environment VITE_BACKEND_URL...</div>
                <div className="console-line text-highlight">&gt; System check sequence completed. Status updated automatically.</div>
              </div>
            </div>
          </div>
        </div>
      </main>

      <footer className="dashboard-footer">
        <span className="footer-left">PROTOCOL TERMINAL // ACTIVE_LINK_VERIFICATION</span>
        <span className="footer-right">© 2026 NODESTRIKE INC. ALL RIGHTS RESERVED.</span>
      </footer>
    </div>
  )
}

export default App
