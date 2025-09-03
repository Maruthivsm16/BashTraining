#!/bin/bash
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
commit_msg=${1:-"auto commit $timestamp"}
branch=$(git branch --show-current)
echo "staging all changes"
git add -A 
echo "Committing with message: $commit_msg"
git commit -m "$commit_msg"
echo "pushing to remote"
git push origin "$branch"
echo " Done!"
