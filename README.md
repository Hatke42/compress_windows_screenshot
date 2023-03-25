# Automated Windows Screenshots save and compress (Win + shift + s)
This PowerShell script runs continuously and monitors the clipboard for any images. When you press shortcut 'Windows + shift + s' an image is copied to the clipboard, then script automatically saved this image to a specified directory, and then optimized using the Squoosh CLI library. The optimized image is then copied to the clipboard, replacing the original image. The optimized image is saved in JPEG and WebP or PNG format, depending on the size of the original image.

## Demo

![image](https://user-images.githubusercontent.com/28193939/227714102-0e201c81-f092-4775-99c3-084bbdeddcd5.png)

![image](https://user-images.githubusercontent.com/28193939/227714211-ca25ba03-f298-41f8-9fa2-18480e8a55f9.png)


In this demo it's reducing the Image Size by 90% 

## Installation 
npx is required to run the script otherwise install squoosh-cli from npm and edit script according to that.
```bash
  npm i -g npx
```

## How to Use

You can create a basic task shedular task and run this script at log on so automatically screenshots will store and compress in the background.
The argument for task schedular to run the script in background 
``
-WindowStyle Hidden
``

- Open PowerShell.
- Navigate to the directory where you saved the script using the cd command.
- Run the script by entering its name with the extension .ps1.
- The script will start running and monitoring the clipboard for images.
- When an image is copied to the clipboard, it will be saved to the specified directory and optimized.
- The optimized image will replace the original image on the clipboard and can be pasted into any application.
- Note: Make sure to update the file paths in the script to match your desired directory for saving and optimizing the images.
