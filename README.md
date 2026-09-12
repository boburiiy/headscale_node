# Headscale Node - Render Deployment

Self-hosted WireGuard controller deployed on Render with Supabase PostgreSQL database.

## Features

- **Direct Connections Only**: Drop connections on fallback, no third-party relays
- **Supabase PostgreSQL**: All state stored in Supabase database
- **Render Hosting**: Deploy directly from this repository
- **No External Relays**: All traffic routed through this controller or dropped

## Prerequisites

1. A Render account (https://render.com)
2. A Supabase project (https://supabase.com)
3. A PostgreSQL database in Supabase

## Deployment Steps

### 1. Create Supabase PostgreSQL Database

1. Go to [Supabase Console](https://app.supabase.com)
2. Create a new project or use existing one
3. Go to Project Settings → Database
4. Note your connection details:
   - Host (db.*.supabase.co)
   - Port (usually 5432)
   - Database name
   - Username
   - Password

### 2. Deploy to Render

1. Push this repository to GitHub
2. Go to [Render Dashboard](https://dashboard.render.com)
3. Click "New +" → "Web Service"
4. Connect your GitHub repository
5. Configure:
   - **Name**: `headscale`
   - **Environment**: `Docker`
   - **Build Command**: (leave empty)
   - **Start Command**: `headscale serve`
   - **Plan**: Standard or higher

### 3. Set Environment Variables

In Render Dashboard, add these under "Environment":

```
DB_HOST=db.xxxxx.supabase.co
DB_PORT=5432
DB_USER=postgres
DB_NAME=postgres
DB_PASS=your_supabase_password
```

### 4. Configure Ports

Make sure these ports are exposed:
- **8080**: HTTP (API)
- **50443**: UDP (WireGuard)

## Configuration

### config.yaml

Main Headscale configuration with:
- PostgreSQL connection to Supabase
- Direct connection mode (no relays)
- Drop on fallback enabled
- Health checks configured

### derp.yaml

DERP relay configuration with all relays disabled for direct-only connections.

### acl.yaml

Access Control List for connection policies. Modify to match your needs.

## Usage

### Connect a Device

```bash
headscale nodes register
```

### Create User

```bash
headscale users create default
```

### Generate Auth Key

```bash
headscale preauthkeys create --user default --reusable
```

## Monitoring

- View logs in Render Dashboard
- Metrics endpoint: `http://localhost:9090/metrics`
- Health check: `http://localhost:8080/health`

## Troubleshooting

### Connection Issues

1. Verify Supabase connection details
2. Check database firewall rules allow Render IP
3. Enable all required ports in firewall

### Relay Fallback

This configuration drops connections on relay fallback. If nodes can't connect:
1. Check NAT traversal isn't needed
2. Verify both clients have direct line-of-sight connectivity
3. Use static IP or port forwarding for clients

## Security Notes

- Use HTTPS for API communication
- Rotate database passwords regularly
- Restrict database access to Render IP
- Use strong authentication tokens
- Keep Headscale updated

## Resources

- [Headscale Documentation](https://headscale.net)
- [Render Documentation](https://render.com/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [WireGuard Documentation](https://www.wireguard.com)
