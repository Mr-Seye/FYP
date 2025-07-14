# 🔐 Network Security Simulation Project

A Cyber Security final year project demonstrating a **containerised environment** to evaluate various network security configurations. This proof-of-concept allows flexible setup of network topologies and scenarios using Docker and Kathará, including implementations of **Intrusion Detection and Prevention Systems (IDS/IPS)** with Snort.

---

![GitHub](https://img.shields.io/github/last-commit/yourusername/network-security-simulation?logo=github)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Kathará](https://img.shields.io/badge/Kathará-Networking-blueviolet)
![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04-E95420?logo=ubuntu&logoColor=white)
![Oracle VM](https://img.shields.io/badge/Oracle%20VM-VirtualBox-blue)

---

## 📦 Features

- 🐳 Containerised simulation with Docker
- 🔁 Customisable network topologies via Kathará
- 🛡️ Snort-based IPS/IDS capabilities
- 🧪 Static and dynamic routing setups
- 🖥️ Graphical support for terminal-based simulations (via X11 forwarding)

---

## 🛠️ Technologies Used

- Docker 26.1.0  
- Kathará 3.7.4  
- Snort  
- Oracle VirtualBox  
- Ubuntu 20.04 LTS  

---

## 📥 Installation

1. **Download the project files**  
   Clone the repository or download the ZIP.

2. **Extract the files**  
   Ensure the directory contains:
   - Dockerfile  
   - Snort rules  
   - Network topology configs  

---

## 🚀 Usage

### 🔧 Build the Docker image

```bash
docker build -t kathara/seye_snort:latest .

```

## 🧱 Run the container

```bash
docker run \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -u root \
  --cap-add NET_ADMIN \
  -it kathara/seye_snort:latest
```

## 🧩 Argument Breakdown

    -e DISPLAY=$DISPLAY: enables GUI for Kathará's xterm

    -v /tmp/.X11-unix:/tmp/.X11-unix: shares X11 socket for GUI apps

    -v /var/run/docker.sock:/var/run/docker.sock: enables Docker access inside container

    -u root: needed for network interfaces

    --cap-add NET_ADMIN: allows creation/configuration of virtual networks

    -it: interactive terminal

    Image format: kathara/seye_snort:latest

    ⚠️ Not using Docker-in-Docker means some security trade-offs (e.g., root, capabilities) apply.

## 📋 Prerequisites

- Ubuntu 20.04 LTS (VM recommended)
- Docker 26.1.0
- Kathará 3.7.4
- VirtualBox installed & virtualisation enabled
- Root privileges in VM
- X11 configured for GUI terminal support

## 👨‍💻 Author

Jordan Ogunseye

## 🪪 License

This project is licensed under the Apache 2.0 License.

