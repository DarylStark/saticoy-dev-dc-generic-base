# Use a minimal base image
FROM debian:12.7-slim AS base

# Configure package manager
RUN apt-get update

# Install needed tools
RUN apt-get install -y --no-install-recommends \
    curl \
    git \
    less \
    sudo \
    vim \
    wget \
    openssh-client \
    bash-completion \
    iputils-ping \
    ca-certificates


# Install GitHub CLI
RUN mkdir -p -m 755 /etc/apt/keyrings
RUN wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
RUN sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN apt update
RUN apt install gh -y

# Create a non-root user and group
RUN useradd --home-dir /home/developer --create-home --skel /etc/skel --shell /bin/bash --uid 1001 developer

# Set the working directory for the new user
WORKDIR /home/developer

# Copy VIM configuration
COPY ./vim/vimrc /home/developer/.vimrc

# Copy BASH configuration
COPY ./bash/bashrc /home/developer/.bashrc.slough
RUN echo "source /home/developer/.bashrc.slough" >> /home/developer/.bashrc

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

# Download Git completion script
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O /etc/bash_completion.d/git-completion.bash

# Change ownership of the home directory and workspace directory
RUN chown -R developer:developer /home/developer
RUN chown -R developer:developer /workspaces

# Remove package manager cache
RUN rm -rf /var/lib/apt/lists/*

# Switch to the non-root user
USER developer

# Configure Starship
RUN mkdir -p .config
RUN mkdir -p StarshipPrompt
ENV PROMPTNAME="BASE"

# Source the Git completion script in .bashrc
RUN echo "source /etc/bash_completion.d/git-completion.bash" >> /home/developer/.bashrc

# Set the default command to bash
CMD ["bash"]