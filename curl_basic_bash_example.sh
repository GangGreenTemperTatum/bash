#!/bin/bash
CURL=$(which curl)
CURLARGS="GET" 
EXAMPLEDOMAIN="https://example.com"
$CURL $CURLARGS $EXAMPLEDOMAIN
