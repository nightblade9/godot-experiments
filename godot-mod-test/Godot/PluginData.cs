using GameApi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameApi
{
    public class PluginData
    {
        public PluginData(string fileName)
        {
            this.DllName = fileName;
        }

        public string DllName { get; set; }
        public List<AbstractMonster> Monsters { get; set; }
        public List<ILevelGenerator> LevelGenerators { get; set; }
    }
}
