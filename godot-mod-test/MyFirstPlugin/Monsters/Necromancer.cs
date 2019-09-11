using GameApi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFirstPlugin.Monsters
{
    public class Necromancer : AbstractMonster
    {
        public override int Health { get; set; } = 250;
        public override string Name { get; set; } = "Necromancer";
        public override int Strength { get; set; } = 7;
    }
}
