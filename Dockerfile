# Start from Ubuntu
FROM ubuntu:latest

# Update and install Apache2, and clean up
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Fix the AH00558 warning by creating a dummy ServerName
# This is optional but good practice
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add your HTML content
ADD index.html /var/www/html/

# EXPOSE is optional, but good documentation
EXPOSE 80

# THE CRITICAL FIX: Run Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
