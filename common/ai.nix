# AI & Machine Learning — Bluefin "Bluespeed" equivalent
#
# Ollama provides a local LLM server with an OpenAI-compatible API.
# Bluefin uses ramalama for this; Ollama is the NixOS-native equivalent.
# Models are stored locally and served at http://localhost:11434
#
# Usage:
#   ollama pull llama3.2        # Download a model
#   ollama run llama3.2         # Chat with a model
#   ollama serve                # Start API server (auto-started by systemd)
#   ollama list                 # List downloaded models
{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # NVIDIA RTX 4060 — use GPU for inference
  };

  environment.systemPackages = with pkgs; [
    ollama # CLI is also available outside the service
  ];
}
