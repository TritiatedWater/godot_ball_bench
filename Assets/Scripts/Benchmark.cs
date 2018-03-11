using System;
using System.Collections.Generic;
using Godot;

public class Benchmark : Node {

        //[Export]
        //public NodePath fpsLabel;

        public int startTime;
        public int curTime;
        public int fps;
        public float frameTime;
        public int elapsed;

        public int avgFps;
        public int prevFps;

        public int startTick;
        public int curTick;
        public int prevTick;
        public int elapsedTick;

        List<int> tickArr = new List<int>();
        List<int> fpsArr = new List<int>();

        public Label fpsLabel;

        public override void _Ready() {

                Input.SetMouseMode(Input.MouseMode.Captured);
                OS.SetWindowFullscreen(true);
                fpsLabel = (Godot.Label) GetNode("Panel/FPS");
                startTime = OS.GetUnixTime();
                startTick = OS.GetTicksMsec();
                prevTick = startTick;
                SetProcess(true);

        }

        public override void _Process(float delta) {
                fpsLabel.Text = "FPS: " + Engine.GetFramesPerSecond().ToString();
                fps += 1;

                if (Input.IsActionJustPressed("ui_cancel")) {
                        Input.SetMouseMode(Input.MouseMode.Visible);
                        GetTree().Quit();
                }
                if (Input.IsActionJustPressed("restart")) {
                        GetTree().ReloadCurrentScene();
                }

                curTime = OS.GetUnixTime();
                elapsed = curTime - startTime;

                if ((elapsed - prevTick) != 0) {
                        fpsArr.Add((int) Engine.GetFramesPerSecond());
                }

                prevFps = elapsed;
                curTick = OS.GetTicksMsec();
                tickArr.Add(curTick - prevTick);;
                prevTick = curTick;

                if (elapsed > 360) {
                        avgFps = fps / elapsed;
                        elapsedTick = curTick - startTick;
                        frameTime = elapsedTick / fps;
                        tickArr.Sort();
                        fpsArr.Sort();

                        GD.Print("Elapsed Time: ", elapsed, " seconds");
                        GD.Print("AVG FPS: ", fps / elapsed);
                        GD.Print("AVG Frame Time: ", frameTime , " milliseconds per FPS");
                        GD.Print("0.1 % High Frame Time: ", tickArr[((int)0.99 * fps)]);
                        GD.Print("0.1 % Low FPS: ", fpsArr[(int)(0.01 * fps)]);
                        GetTree().Quit();
                        
                }
        }
}