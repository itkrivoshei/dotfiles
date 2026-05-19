# Dotfiles

Personal development environment configuration and bootstrap scripts.

## Overview

This repository contains my development environment setup for terminal-based workflows.

It includes configuration for Zsh, Kitty terminal, Starship prompt, Prettier formatting, and shell-based setup steps.

The goal of this repository is to make my local development environment reproducible, easier to restore, and easier to maintain across machines.

## Included Configs

- Zsh shell configuration
- Zsh autosuggestions
- Zsh syntax highlighting
- Zsh history substring search
- Kitty terminal configuration
- Dracula theme for Kitty
- Starship prompt initialization
- Prettier formatting defaults
- Basic shell bootstrap commands

## Project Structure

    .
    ├── install.sh
    ├── config/
    │   ├── zsh/
    │   │   └── .zshrc
    │   ├── kitty/
    │   │   ├── kitty.conf
    │   │   ├── dracula.conf
    │   │   └── diff.conf
    │   └── prettier/
    │       └── .prettierrc
    ├── LICENSE
    └── README.md

## Usage

Clone the repository:

    git clone https://github.com/itkrivoshei/dotfiles.git
    cd dotfiles

Run the install script:

    ./install.sh

Review the script before running it on a new machine.

## Manual Setup Notes

The environment uses:

- Zsh as the main shell
- Kitty as the terminal emulator
- Starship as the shell prompt
- FiraCode Nerd Font
- Dracula theme
- Prettier with 2-space indentation

## Safety Notes

This repository is designed for my personal development setup.

Before using it on another system, review all scripts and configuration files. Some settings may be specific to my workflow or machine preferences.

## Status

This repository is maintained as a personal development environment bootstrap.

It is kept public to show my approach to shell configuration, terminal setup, and reproducible developer tooling.
