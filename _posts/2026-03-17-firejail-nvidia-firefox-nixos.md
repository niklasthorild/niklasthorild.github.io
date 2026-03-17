---
title: "Fix NVIDIA GPU Acceleration in Firejailed Firefox on NixOS"
date: 2026-03-17 18:35:38 +0100
categories: [NixOS, Fixes]
tags: [nixos, firejail, nvidia, firefox, webgl]
---

If you're running Firefox through Firejail on NixOS with an NVIDIA GPU, you may
notice that hardware acceleration and WebGL are broken. Checking `about:support`
reveals that GPU acceleration is blocked or unavailable.

## The Problem

Firejail's default Firefox profile restricts access to `/etc`, which prevents
Firefox from reading the NVIDIA EGL vendor configuration files it needs to
initialise GPU acceleration.

## The Fix

Add a local Firejail override for Firefox in your `configuration.nix`:
```nix
environment.etc."firejail/firefox.local".text = ''
  private-etc egl,nvidia
'';
```

This extends Firejail's `private-etc` whitelist to include the `egl` and
`nvidia` directories, giving Firefox access to the driver config it needs
without disabling sandboxing entirely.

After rebuilding (`sudo nixos-rebuild switch`), relaunch Firefox via Firejail
and check `about:support` — GPU acceleration should now show as available!
