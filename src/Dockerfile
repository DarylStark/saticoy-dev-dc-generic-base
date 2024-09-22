# Use a minimal base image
FROM alpine:3.20.3 AS base

# Install full applications where the Alpine package is not sufficient
RUN apk add --no-cache grep less

# Install needed tools
RUN apk add --no-cache bash wget git vim sudo

# Create a non-root user and group
RUN adduser -h /home/developer -s /bin/bash -u 1001 -D developer

# Set the working directory for the new user
WORKDIR /home/developer

# Copy VIM configuration
COPY ./vim/vimrc /home/developer/.vimrc

# Copy BASH configuration
COPY ./bash/bashrc /home/developer/.bashrc

# Copy Starship configuration
COPY ./starship/starship.toml /home/developer/.config/starship.toml
COPY ./starship/StarshipPrompt/* /home/developer/StarshipPrompt/

# Directory for Dev Container
RUN mkdir -p /workspaces

# Allow the developer user to use sudo without a password
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Starship
RUN wget https://starship.rs/install.sh
RUN chmod +x install.sh
RUN ./install.sh -y
RUN rm ./install.sh

# Change ownership of the home directory and workspace directory
RUN chown -R developer:developer /home/developer
RUN chown -R developer:developer /workspaces

# Switch to the non-root user
USER developer

# Configure Starship
RUN mkdir -p .config
RUN mkdir -p StarshipPrompt
ENV PROMPTNAME="BASE"

# Set the default command to bash
CMD ["bash"]