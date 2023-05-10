if exist "%~dp0pretrained" (
        echo dir .\pretrained checked.
    ) else (
        echo failed. generating dir .\pretrained.
        mkdir pretrained
    )
if exist "%~dp0uvr5_weights" (
        echo dir .\uvr5_weights checked.
    ) else (
        echo failed. generating dir .\uvr5_weights.
        mkdir uvr5_weights
    )

pause