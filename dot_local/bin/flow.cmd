@echo off
rem Windows wrapper for the nushell `flow` script. Requires nu on PATH.
nu "%~dp0flow" %*
