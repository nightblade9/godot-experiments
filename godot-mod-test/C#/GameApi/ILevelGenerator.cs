using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameApi
{
    public interface ILevelGenerator
    {
        bool[,] GenerateMap();
    }
}
