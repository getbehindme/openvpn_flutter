# VPN Configuration Setup

This example app loads the VPN configuration from an external file for security reasons.

## Setup Instructions

1. Copy the example configuration file:
   ```
   cp assets/vpn_config.ovpn.example assets/vpn_config.ovpn
   ```

2. Edit `assets/vpn_config.ovpn` with your actual VPN credentials:
   - Replace `YOUR_VPN_SERVER_ADDRESS` with your VPN server hostname
   - Replace `PORT` with your VPN server port
   - Replace `YOUR_CA_CERTIFICATE_HERE` with your CA certificate content
   - Replace `YOUR_PRIVATE_KEY_HERE` with your private key content
   - Replace `YOUR_CLIENT_CERTIFICATE_HERE` with your client certificate content

3. The `vpn_config.ovpn` file is automatically excluded from git tracking for security.

## Security Notes

- Never commit the actual `vpn_config.ovpn` file to version control
- The `.gitignore` file is configured to exclude `*.ovpn` files
- Keep your private keys and certificates secure
- Consider using environment-specific configuration files for different deployment environments

## File Structure

```
assets/
├── vpn_config.ovpn.example  # Template file (safe to commit)
└── vpn_config.ovpn          # Actual config (excluded from git)
```
