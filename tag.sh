#!/bin/bash

# parameters
tag=$1

# delete tag
git tag -d $tag
git push --delete origin $tag

# tag head
git tag $tag
git push origin --tags
