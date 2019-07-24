Remove-Item -Recurse -Force .\deploy\
New-Item -Type Directory .\deploy\
Set-Location '.\Snipping OCR\tessdata\'

if (-not ( Test-Path "spa.wordlist")) {
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/tessdata/master/ara.traineddata -OutFile ara.traineddata 
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/tessdata/master/eng.traineddata -OutFile eng.traineddata 
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/tessdata/master/spa.traineddata -OutFile spa.traineddata  
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/ara.config	 -OutFile ara.config	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/ara.numbers	 -OutFile ara.numbers	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/ara.punc	 -OutFile ara.punc	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/ara.singles_text	 -OutFile ara.singles_text	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/ara.training_text	 -OutFile ara.training_text	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/ara.unicharset	 -OutFile ara.unicharset	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/ara.wordlist	 -OutFile ara.wordlist	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/desired_characters	 -OutFile desired_characters	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/forbidden_characters -OutFile forbidden_characters
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/ara/okfonts.txt	 -OutFile okfonts.txt	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/desired_characters	 -OutFile desired_characters	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/eng.numbers	 -OutFile eng.numbers	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/eng.punc	 -OutFile eng.punc	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/eng.singles_text	 -OutFile eng.singles_text	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/eng.training_text	 -OutFile eng.training_text	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/eng.unicharambigs	 -OutFile eng.unicharambigs	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/eng.unicharset	 -OutFile eng.unicharset	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/eng.wordlist	 -OutFile eng.wordlist	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/eng/okfonts.txt -OutFile okfonts.txt
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/desired_characters	 -OutFile desired_characters	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/okfonts.txt -OutFile okfonts.txt
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.numbers	 -OutFile spa.numbers	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.params-model	 -OutFile spa.params-model	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.punc	 -OutFile spa.punc	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.singles_text	 -OutFile spa.singles_text	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.training_text	 -OutFile spa.training_text	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.unicharambigs	 -OutFile spa.unicharambigs	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.unicharset	 -OutFile spa.unicharset	
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/tesseract-ocr/langdata_lstm/master/spa/spa.wordlist -OutFile spa.wordlist
}
else {
    Write-Output "*****************           Files Exist *************************"
}
Set-Location ..
dotnet publish -c Release -r win-x64 /p:PublishSingleFile=true 
Move-Item .\bin\Release\netcoreapp3.0\win-x64\publish\Snipping_OCR.exe ..\deploy\
Copy-Item .\tessdata ..\deploy\  -Recurse -Force
Copy-Item .\App.config ..\deploy\   -Force
Copy-Item .\edit_find.ico ..\deploy\   -Force
Copy-Item .\bin\Release\netcoreapp3.0\win-x64\x64\ ..\deploy\ -Recurse
Copy-Item .\bin\Release\netcoreapp3.0\win-x64\x86\ ..\deploy\ -Recurse
Set-Location ..