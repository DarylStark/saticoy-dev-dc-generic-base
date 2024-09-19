# Use a minimal base image
FROM alpine:3.20.3 AS base

# Create a non-root user and group
RUN addgroup -S developer && adduser -S developer -G developer

# Create the sudo group and add the developer user to it
RUN addgroup sudo && adduser developer sudo

# Set the working directory for the new user
WORKDIR /home/developer

# Change ownership of the home directory
RUN chown -R developer:developer /home/developer

# Install dependencies
RUN apk add --no-cache bash wget git vim sudo

# Allow the developer user to use sudo without a password
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Starship
RUN wget https://starship.rs/install.sh
RUN chmod +x install.sh
RUN ./install.sh -y
RUN rm ./install.sh

# Switch to the non-root user
USER developer

# Configure Starship
RUN mkdir -p .config
RUN mkdir -p StarshipPrompt
COPY ./starship/starship.toml /home/developer/.config/starship.toml
COPY ./starship/StarshipPrompt/* /home/developer/StarshipPrompt/
ENV PROMPTNAME="BASE"

# Configure Vim
COPY ./vim/vimrc /home/developer/.vimrc

# Configure Bash
COPY ./bash/bashrc /home/developer/.bashrc

# Set the default command to bash
CMD ["bash"]