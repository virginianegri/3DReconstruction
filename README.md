# 3D Reconstruction

Stereo reconstruction of a dinosaur from 36 viewpoints using Shape from Silhouette

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Background

This program creates a 3D reconstruction of a dinosaur from 36 viewpoints taken one every 10°.

The technique used is Shape from Silhouette. 

A Silhouette of the dinosaur is extracted from each image through colour segmentation.

A 3D grid is created with voxel resolution of 100 (can be modified).

The 2D points in the images are projected onto the 3D space using the provided projection matrices.

All points corresponding to the background are carved.

### Installing

Download or clone the repository.

Open the 3DReconstruction directory in MATLAB.

Open the main.m script and select the desired resolution (default 100).

Run the main.m script in the command window.

```
run main.m
```

## Built With

* [Matlab CV Toolbox](https://au.mathworks.com/products/computer-vision.html) - The Matlab framework used

## Authors

* **Virginia Negri** 
