# Use NVIDIA CUDA image for GPU acceleration
FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

LABEL maintainer="İrem Urhan"

# Set the working directory inside the container
WORKDIR /pytorch_simclr

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    git \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch and TorchVision with CUDA support
RUN pip3 install --upgrade pip && \
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Copy project files
COPY . /pytorch_simclr

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /pytorch_simclr/requirements.txt

# Set default command with your specific parameters
CMD ["python3", "run.py", \
     "-dataset-name", "cifar10", \
     "-a", "resnet50", \
     "--epochs", "100", \
     "-b", "512", \
     "--lr", "0.1", \
     "--wd", "1e-6"]