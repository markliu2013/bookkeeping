#!/bin/bash
export $(grep -v '^#' .env | xargs)
./mvnw spring-boot:run
