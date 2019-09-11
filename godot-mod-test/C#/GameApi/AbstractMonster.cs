using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GameApi
{
    public abstract class AbstractMonster
    {
        public abstract string Name { get; set; }
        public abstract int Health { get; set; }
        public abstract int Strength { get; set; }
    }
}
