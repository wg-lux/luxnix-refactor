{ pkgs, lib, config, inputs, ... }:
let
  buildInputs = with pkgs; [
    python311Full
    stdenv.cc.cc
    tesseract
    glib
    openssh
    openssl
    black
    nixpkgs-fmt
  ];

in 
{

  # A dotenv file was found, while dotenv integration is currently not enabled.
  dotenv.enable = false;
  dotenv.disableHint = true;

  packages = with pkgs; [
    cudaPackages.cuda_nvcc
    age
    openssh
    stdenv.cc.cc
    tesseract
    sops
    openssl
    black
    nixpkgs-fmt
  ];

  env = {
    LD_LIBRARY_PATH = "${
      with pkgs;
      lib.makeLibraryPath buildInputs
    }:/run/opengl-driver/lib:/run/opengl-driver-32/lib";
  };

  languages.python = {
    enable = true;
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  scripts = {
    hello.exec = "${pkgs.uv}/bin/uv run python hello.py";
    utest.exec = "${pkgs.uv}/bin/uv run python -m unittest";
  };

  tasks = {
  
  };

  processes = {
  };

  enterShell = ''
    . .devenv/state/venv/bin/activate
    hello
  '';

  enterTest = ''
    nvcc -V
    python -m unittest
  '';
}
