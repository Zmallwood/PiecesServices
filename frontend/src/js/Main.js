/* Copyright 2025 Andreas Åkerberg
 * See LICENSE for license details.
 */
import { Present, UpdateGameState} from './Commands.js';

var images = {};

function IsTouchDevice() {
    return window.matchMedia("(pointer: coarse)").matches;
}

function Connect()
{
    const canvas = document.getElementById("canvas");
    const ctx = canvas.getContext("2d");
    
    ctx.canvas.width = window.innerWidth;
    ctx.canvas.height = window.innerHeight;
    ctx.font = "bold 100% sans-serif";
    
    let drawCommands = [];
    
    /*ws.onopen = function()
    {
        ws.send("CanvasSize;" + ctx.canvas.width + ";" + ctx.canvas.height);     // send a message
    };
    
    ws.onmessage = function(evt)
    {
        ProcessMessage(ws, evt, ctx, images, drawCommands);
    };
    
    ws.onclose = function()
    {
        console.log("Connection closed.");
    };*/
    
    document.addEventListener(
        "keydown", function(e) {
    });
    
    document.addEventListener(
        "keyup", function(e) {
    });
    
    document.addEventListener(
        "mousedown", function(e) {
    });
    
    document.addEventListener(
        "mouseup", function(e) {
    });
    
    document.addEventListener(
        "touchstart", function(e) {
        let touch = e.touches[0];
        /*ws.send("MouseMove;" + touch.clientX + ";" + touch.clientY + ";");*/
        /*ws.send("MouseButtonPress;" + leftButtonCode);*/
    });
    
    document.addEventListener(
        "touchend", function(e) {
        /*ws.send("MouseButtonRelease;" + leftButtonCode);*/
    });
    
    document.addEventListener(
        "mousemove", function(e) {
    });
    
    var timeout;
    
    window.addEventListener(
        'resize', function() {
        
        clearTimeout(timeout);
        
        timeout = setTimeout(
            function() {
            ctx.canvas.width = window.innerWidth;
            ctx.canvas.height = window.innerHeight;
            /*ws.send("CanvasSize;" + ctx.canvas.width + ";" + ctx.canvas.height); // send a message*/
            ctx.font = "bold 100% sans-serif";
        }, 250);
    });
    
    function DrawFrame()
    {
        requestAnimationFrame(DrawFrame);
        ctx.save();
        
        for (const cmd of drawCommands)
        {
            eval(cmd);
        }
        
        ctx.restore();
        
        /*if (ws.readyState === WebSocket.OPEN)
        {
            ws.send("FrameFinished");
        }*/
    };

    UpdateGameState(ctx, images, drawCommands);
    /*DrawImage(ctx, images, drawCommands, "GroundGrass", 0.0, 0.0, 0.1, 0.1);*/
    //Present(drawCommands);
    
    DrawFrame();
};

function Init()
{
    Connect();
};

window.Init = Init;
