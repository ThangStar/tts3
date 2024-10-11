# Use an official Ubuntu base image
FROM python:3.10
# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
# Update package list and install necessary packages including Python 3.10


# Create a working directory
WORKDIR /app

# Copy all files from the current directory to the /app directory in the container
COPY . .

RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python -m venv .env && \
    . .env/bin/activate && \
    git submodule update --init --recursive && \
    cd TTS && \
    git fetch --tags && \
    git checkout 0.1.1 && \
    echo "Installing TTS..." && \
    pip install --use-deprecated=legacy-resolver -e . -q && \
    cd .. && \
    echo "Installing other requirements..." && \
    pip install -r requirements.txt -q && \
    echo "Downloading Japanese/Chinese tokenizer..." && \
    python -m unidic download && \
    touch .env/ok

# Set the default command to run when starting the container
CMD ["/bin/bash"]