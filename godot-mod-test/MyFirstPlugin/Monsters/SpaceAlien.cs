using GameApi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFirstPlugin.Monsters
{
    public class SpaceAlien : AbstractMonster
    {
        public override int Health { get; set; } = 100;
        public override string Name { get; set; } = "Space Alien";
        public override int Strength { get; set; } = 10;
    }
}
