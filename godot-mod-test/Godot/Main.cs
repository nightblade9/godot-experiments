using GameApi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using Directory = System.IO.Directory;

public class Main : Godot.Node2D
{
    private const string PluginsDirectoryName = "Plugins";
    private List<PluginData> pluginData = new List<PluginData>();

    public override void _Ready()
    {
        this.PopulatePluginAssemblies();
    }

    private void PopulatePluginAssemblies()
    {
        var list = this.GetNode(@"Panel/ItemList") as Godot.ItemList;
        
        if (Directory.Exists(PluginsDirectoryName)) {
            var allFiles = Directory.GetFiles(PluginsDirectoryName, "*.dll");

            foreach (var fileName in allFiles) {
                var assembly = Assembly.LoadFile(fileName);

                var data = new PluginData(fileName);

                data.Monsters = new List<AbstractMonster>();
                var monsters = assembly.GetTypes().Where(t => t.BaseType == typeof(AbstractMonster));

                foreach (var monsterType in monsters)
                {
                    var instance = (AbstractMonster)monsterType.GetConstructor(new Type[0]).Invoke(new object[0]);
                    data.Monsters.Add(instance);
                }

                data.LevelGenerators = new List<ILevelGenerator>();
                var generators = assembly.GetTypes().Where(t => t.GetInterfaces().Any(i => i.Name.Contains("ILevelGenerator")));

                foreach (var generatorType in generators)
                {
                    var instance = (ILevelGenerator)generatorType.GetConstructor(new Type[0]).Invoke(new object[0]);
                    data.LevelGenerators.Add(instance);
                }

                list.AddItem(fileName);
                pluginData.Add(data);
            }
        } else {
            list.AddItem("Plugins directory doesn't exist.");
        }
    }

    public void _on_ItemList_item_selected(int index)
    {
        var data = this.pluginData[index];
        var label = (Godot.Label)this.GetNode("Panel/Label");

        var builder = new StringBuilder();
        builder.Append("DLL: ").AppendLine(data.DllName);

        builder.AppendLine("");
        builder.AppendLine($"{data.Monsters.Count} Monsters:");
        foreach (var monster in data.Monsters)
        {
            builder.AppendLine($"        {monster.Name}: {monster.Health} health, {monster.Strength} strength");
        }

        builder.AppendLine("");
        builder.AppendLine($"{data.LevelGenerators.Count} Level Generators:");
        foreach (var generator in data.LevelGenerators)
        {
            builder.AppendLine($"        {generator.GetType().Name}");
        }

        label.Text = builder.ToString();
    }

    //    public override void _Process(float delta)
    //    {
    //        // Called every frame. Delta is time since last frame.
    //        // Update game logic here.
    //        
    //    }
}
