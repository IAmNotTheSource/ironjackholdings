#!/bin/bash

# 🜁 BUSINESS SITE DEPLOYMENT SCRIPT
# For Stripe verification and sovereign presence

echo "=================================="
echo "🜁 DEPLOYING BUSINESS SITE"
echo "=================================="

# Option 1: Deploy to GitHub Pages
deploy_github() {
    echo "Deploying to GitHub Pages..."
    
    # Create a new repo or use existing
    echo "1. Create a new repo called 'ironjack' on GitHub"
    echo "2. Run these commands:"
    echo ""
    echo "cd exponential/business-site"
    echo "git init"
    echo "git add ."
    echo "git commit -m '🜁 Iron Jack Holdings business site'"
    echo "git branch -M main"
    echo "git remote add origin https://github.com/YOUR_USERNAME/ironjack.git"
    echo "git push -u origin main"
    echo ""
    echo "3. Go to Settings → Pages → Deploy from main branch"
    echo "4. Your site will be live at: https://YOUR_USERNAME.github.io/ironjack"
}

# Option 2: Deploy to DigitalOcean (ironjack-hum-node)
deploy_digitalocean() {
    echo "Deploying to DigitalOcean..."
    
    SERVER="138.68.231.2"
    
    # Copy files to server
    scp index.html root@$SERVER:/var/www/html/
    
    # Set up nginx if needed
    ssh root@$SERVER << 'EOF'
        # Install nginx if not present
        if ! command -v nginx &> /dev/null; then
            apt update
            apt install -y nginx
        fi
        
        # Configure nginx
        cat > /etc/nginx/sites-available/ironjack << 'NGINX'
server {
    listen 80;
    server_name ironjack-hum-node 138.68.231.2;
    
    root /var/www/html;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
NGINX
        
        # Enable site
        ln -sf /etc/nginx/sites-available/ironjack /etc/nginx/sites-enabled/
        
        # Restart nginx
        systemctl restart nginx
        
        echo "✅ Site deployed to http://138.68.231.2"
EOF
}

# Option 3: Deploy to 153hz.bond (if you have domain pointed to server)
deploy_domain() {
    echo "To deploy to 153hz.bond:"
    echo "1. Point your domain to 138.68.231.2 or 134.122.123.48"
    echo "2. Run the DigitalOcean deployment"
    echo "3. Install SSL with certbot:"
    echo ""
    echo "ssh root@YOUR_SERVER"
    echo "apt install -y certbot python3-certbot-nginx"
    echo "certbot --nginx -d 153hz.bond"
}

# Show options
echo "Choose deployment method:"
echo "1) GitHub Pages (easiest, free)"
echo "2) DigitalOcean (already have servers)"
echo "3) Custom domain (153hz.bond)"
echo ""
echo "For Stripe verification, any of these will work!"
echo ""
echo "=================================="
echo "QUICK OPTION - Local Testing:"
echo "=================================="
echo "cd exponential/business-site"
echo "python3 -m http.server 8000"
echo "Open: http://localhost:8000"
echo ""
echo "=================================="
echo "🜁 The business breathes sovereign"
echo "=================================="
