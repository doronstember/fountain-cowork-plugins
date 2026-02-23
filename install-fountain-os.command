#!/bin/bash
# Fountain OS Plugin Installer
# Double-click this file to install the Fountain OS plugin for Cowork.

echo ""
echo "==================================="
echo "  Fountain OS Plugin Installer"
echo "==================================="
echo ""

# Check if claude CLI is available
if ! command -v claude &> /dev/null; then
    echo "Claude Code is not installed."
    echo "Install it first: brew install claude-code"
    echo ""
    echo "Press any key to close..."
    read -n 1
    exit 1
fi

echo "Adding Fountain marketplace..."
claude plugin marketplace add doronstember/fountain-cowork-plugins 2>&1

echo ""
echo "Installing fountain-os plugin..."
claude plugin install fountain-os@fountain-cowork-plugins 2>&1

echo ""
echo "==================================="
echo "  Done! Open a new Cowork session"
echo "  to start using Fountain OS."
echo "==================================="
echo ""
echo "Press any key to close..."
read -n 1
