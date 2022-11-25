# Image-Feeder
An implementation of iOS Lead Essentials Image Feeder App

[![CI](https://github.com/dhruvilv/Image-Feeder/actions/workflows/CI.yml/badge.svg)](https://github.com/dhruvilv/Image-Feeder/actions/workflows/CI.yml)


# Business Requirements: 

# 1 Happy Case: 

- As an online user I should be able to load images from the internet.
- Subsequently, I should also be able to store images into Cache with a new timestamp. 
- If there is no Cache, then I should be able to create a new cache and new the recently fetched set of images. 

# 2 Sad Case - Network connection Error: 
- If there is a network problem, then I should be able to load the images from latest Cache timestamp. 
- Update the UI with cache data. 
- If there is no cache, then I should display an error message. 

# 3 Sad case - Other Errors: 
- If there is an error fetching images, then display images from latest Cache timestamp. 
- If a cache does not exist yet, then create a Cache and then show error message on the UI. 
