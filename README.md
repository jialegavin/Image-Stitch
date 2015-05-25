# Image-Stitch
Project for image stitch without blending

The reference file includes some files about the theory of image stitch which I used in stitch.



The GUI file is the GUI for the image stitch and inpainting. Main.m is the main window of GUI and you can start with it. The stitch function need more than one image being imported and their name must be in order from the direction. The inpainting function can just import one image.

For stitch function, click on stitch and the stitched image will be shown. The matched points with original image and inlier points with original image can be shown to see if they worked correctly. 

My stitch function do not complete all the steps. I have complete feature matching, image matching and image warp. Bundle adjustment is not included and instead I used image warp to get together the images. I have done some work about gain compensation but there may some problems of it. The blending is missed the reason why there is a line obviously between different images. 

My inpainting function is based on heat equation from https://www.mathworks.com/company/newsletters/articles/applying-modern-pde-techniques-to-digital-image-restoration.html

Some parameters are changed to deal with the RGB images. 

In my inpainting GUI, you can change the parameters of the algorithm. Click on start marking and you can click on two points in the image. The algorithm will work on the path between two points. The radius can change the width of the path and the iteration can change the iteration number of the heat equation which may produce better result. Click on compare, the original image and the recovery image with image inpainting mark image will be shown. 
