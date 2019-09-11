using GameApi;

namespace MyFirstPlugin.Generators
{
    public class CaveGenerator : ILevelGenerator
    {
        public bool[,] GenerateMap()
        {
            return new bool[1, 1];
        }
    }
}
