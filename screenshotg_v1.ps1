# Import the required .NET namespaces
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


while(1){

	$img = [System.Windows.Forms.Clipboard]::GetImage()
	

	if($img) {		
		# File paths
		$imagePath = "C:\Users\Future\Downloads\screenshot\"
		$optimizedImagePath = "C:\Users\Future\Downloads\screenshot\optimized\"
		$optimizedWebpImagePath = "C:\Users\Future\Downloads\screenshot\optimized_webp\"	
		
		# file Names
		$fileName = "Snip_" + (Get-Date -Format "yyyyMMdd_HHmmss") 
		$fileJpg = $fileName + ".jpg"
		$filewebp = $fileName + ".webp"
		$filepng = $fileName + ".png"
		
		$filePath = Join-Path -Path $imagePath -ChildPath $fileJpg
		
		#saving image
		$img.save($filePath)
		#Start-Sleep -Seconds 1
		Write-Host $fileJpg + " Image Successfully Saved"
		
		Set-Location -Path ${imagePath}
		
		
		#getting the size of file
		$fileInfo = Get-Item -Path $filePath
		$sizeInBytes = $fileInfo.Length
		$sizeInKB = [math]::Round($sizeInBytes / 1KB)
		
		#optimizing image 
        #below 300KB text on the image not visible clearly with webp and mozjpeg format so for that sizes oxipng workes great
		if($sizeInKB -gt 300){
			& npx @squoosh/cli --mozjpeg '{"quality": 85}' -d $optimizedImagePath $fileJpg 
            # & "squoosh-cli" --mozjpeg '{"quality": 85}' -d $optimizedImagePath $fileJpg 
            & npx @squoosh/cli --webp '{"quality": 88, "target_size": 0, "target_PSNR": 0, "method": 4, "sns_strength": 50, "filter_strength": 60, "filter_sharpness": 0, "filter_type": 1, "partitions": 0, "segments": 4, "pass": 1, "show_compressed": 0, "preprocessing": 0, "autofilter": 0, "partition_limit": 0, "alpha_compression": 1, "alpha_filtering": 1, "alpha_quality": 100, "lossless": 0, "exact": 0, "image_hint": 0, "emulate_jpeg_size": 0, "thread_level": 0, "low_memory": 0, "near_lossless": 100, "use_delta_palette": 0, "use_sharp_yuv": 0}' -d $optimizedWebpImagePath $fileJpg
            #& "squoosh-cli" --webp '{"quality": 88, "target_size": 0, "target_PSNR": 0, "method": 4, "sns_strength": 50, "filter_strength": 60, "filter_sharpness": 0, "filter_type": 1, "partitions": 0, "segments": 4, "pass": 1, "show_compressed": 0, "preprocessing": 0, "autofilter": 0, "partition_limit": 0, "alpha_compression": 1, "alpha_filtering": 1, "alpha_quality": 100, "lossless": 0, "exact": 0, "image_hint": 0, "emulate_jpeg_size": 0, "thread_level": 0, "low_memory": 0, "near_lossless": 100, "use_delta_palette": 0, "use_sharp_yuv": 0}' -d $optimizedWebpImagePath $fileJpg
			$optimizedImage = $optimizedImagePath + $fileJpg;
		} else {
			& npx @squoosh/cli --oxipng '{"level": 2}' -d $optimizedImagePath $fileJpg
            #& "squoosh-cli" --oxipng '{"level": 2}' -d $optimizedImagePath $fileJpg
			$optimizedImage = $optimizedImagePath + $filepng;
		}
		#Start-Sleep 1

		#checking if image exist
		
		if(Test-Path $optimizedImage){
		  Write-Host "Image Successfully Compressed"
          [System.Windows.Forms.Clipboard]::Clear()
		  
		  # Load the image from file
		  $opImage = [System.Drawing.Image]::FromFile($optimizedImage)

		  # Set the optimized image to the clipboard
		  if($opImage){
		  [System.Windows.Forms.Clipboard]::SetImage($opImage)

		  # Dispose the image object
		  Start-Sleep -Seconds 100
          $opImage.Dispose()
		  [System.Windows.Forms.Clipboard]::Clear()
		  }else {
			  Write-Host "Optimized Image not Found"
		  }
		}else {
		  Write-Host "Failed Compression"
		}
	}
 
	Write-Host "Waiting For Screenshot"
	Start-Sleep -Seconds 5
}
