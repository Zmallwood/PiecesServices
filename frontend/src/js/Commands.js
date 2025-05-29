/* Copyright 2025 Andreas Åkerberg
 * See LICENSE for license details.
 */

let newDrawCommands = [];

export function ProcessCommand(ctx, images, drawCommands, command)
{
    const parts = command.split(";");

    switch (parts[0])
    {
    case "Clear":
    {
        const r = parts[1];
        const g = parts[2];
        const b = parts[3];
        
        newDrawCommands.push(
            "ctx.fillStyle = 'rgb(" + r + "," + g + "," + b + ")';",
            );
        
        newDrawCommands.push(
            "ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);",
            );
        
        break;
    }
    case "DrawImage":
    {
        const imageName = parts[1];
        
        const x = parts[2];
        const y = parts[3];
        const w = parts[4];
        const h = parts[5];
        
        const repeat = parts[6];
        
        const xPx = x * ctx.canvas.width;
        const yPx = y * ctx.canvas.height;
        const wPx = w * ctx.canvas.width;
        const hPx = h * ctx.canvas.height;
        
        if (!images.hasOwnProperty(imageName))
        {
            console.log("Create image " + imageName + " in drawimage");
            let image = new Image();
            
            image.src = "./resources/images/" + imageName + ".png";
            images[imageName] = image;
        }
        
        if (repeat == "true")
        {
            newDrawCommands.push(
                "const pattern = ctx.createPattern(images['" + imageName +
                "'], 'repeat');" +
                "ctx.fillStyle = pattern;" +
                "ctx.fillRect(" + xPx + ", " + yPx + ", " + wPx + ", " + hPx +
                ");"
                );
        }
        else
        {
          console.log("drawimage");
            newDrawCommands.push(
                "ctx.drawImage(images['" +
                imageName +
                "'], " +
                xPx +
                "," +
                yPx +
                "," +
                wPx +
                "," +
                hPx +
                ");",
                );
          console.log(newDrawCommands[0]);
        }
        
        break;
    }
    case "DrawText":
    {
        const text = parts[1];
        
        const x = parts[2];
        const y = parts[3];
        
        const xPx = x * ctx.canvas.width;
        const yPx = y * ctx.canvas.height;
        
        if (parts.length >= 7)
        {
            const r = parts[4];
            const g = parts[5];
            const b = parts[6];
            
            newDrawCommands.push(
                "ctx.fillStyle = 'rgb(" + r + "," + g + "," + b + ")';",
                );
        }
        else
        {
            newDrawCommands.push("ctx.fillStyle = 'rgb(0,0,0)';");
        }
        
        const metrics = ctx.measureText(text);
        const textHeight = metrics.actualBoundingBoxAscent;

        let xOffset = 0;
        let yOffset = 0;
        
        if (parts.length >= 8)
        {
            const centerAlign = parts[7];
            
            if (centerAlign == "true")
            {
                const textWidth = ctx.measureText(text).width;
                xOffset = -textWidth / 2;
                yOffset += textHeight / 2;
            }
        }
        
        newDrawCommands.push(
            "ctx.fillText('" +
            text +
            "'," +
            (xPx + xOffset) +
            "," +
            (yPx + yOffset) +
            ");",
            );
        
        break;
    }
    case "RequestImageDimensions":
    {
        const imageName = parts[1];
        
        if (!images.hasOwnProperty(imageName))
        {
            let image = new Image();
            
            image.src = "./resources/images/" + imageName + ".png";
            images[imageName] = image;
        }
        
        const image = images[imageName];
        
        if (!image.complete)
        {
            image.onload = function()
            {
                var width = image.width;
                var height = image.height;
                
                ws.send(
                    "ProvideImageDimensions;" + imageName + ";" + width + ";" +
                    height + ";");
            };
        }
        
        
        break;
    }
    case "Present":
    {
        drawCommands.length = 0;
        
        for (const entry of newDrawCommands)
        {
            drawCommands.push(entry);
        }
        
        newDrawCommands.length = 0;
        
        break;
    }
    }
}

export function Present(drawCommands)
{
    drawCommands.length = 0;
    
    for (const entry of newDrawCommands)
    {
        drawCommands.push(entry);
    }
    
    newDrawCommands.length = 0;
}

export async function UpdateGameState(ctx, images, drawCommands)
{
    try {
        const response = await fetch("http://localhost:31000"); // Replace with your API endpoint
        if (!response.ok) {
            throw new Error("HTTP error! Status: ${response.status}");
        }
        const data = await response.json(); // Parse JSON response

        for (const command of data["commands"])
        {
          ProcessCommand(ctx, images, drawCommands, command);
        }

        Present(drawCommands);

        console.log(data);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
}
