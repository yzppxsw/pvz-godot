# 植物数据清单

- 游戏：植物大战僵尸 1 代
- 排序依据：原版冒险模式解锁顺序（经网络查证）
- 卡面贴图目录：`res://resources/graphics/Cards/ordered/`
- 动画场景目录：`res://Template/plants/`（文件名与 key 对应，如 `peashooter` → `peashooter.tscn`，为 CharacterBody2D + AnimatedSprite2D 的动画预制体）
- 冷却时间单位：秒

## 标准植物（原版冒险模式解锁顺序）

| id | 卡面贴图文件 | 动画场景 | 中文名 | 英文名 | 阳光花费 | 冷却时间 | 解锁关卡 |
|----|-------------|---------|--------|--------|---------|---------|---------|
| 01 | `01_peashooter.png` | `res://Template/plants/peashooter.tscn` | 豌豆射手 | Peashooter | 100 | 7.5 | 1-1 |
| 02 | `02_sunflower.png` | `res://Template/plants/sunflower.tscn` | 向日葵 | Sunflower | 50 | 7.5 | 1-1 |
| 03 | `03_cherrybomb.png` | `res://Template/plants/cherrybomb.tscn` | 樱桃炸弹 | Cherry Bomb | 150 | 50 | 1-2 |
| 04 | `04_wallnut.png` | `res://Template/plants/wallnut.tscn` | 坚果墙 | Wall-nut | 50 | 30 | 1-3 |
| 05 | `05_potatomine.png` | `res://Template/plants/potatomine.tscn` | 土豆雷 | Potato Mine | 25 | 30 | 1-5 |
| 06 | `06_snowpea.png` | `res://Template/plants/snowpea.tscn` | 寒冰射手 | Snow Pea | 175 | 7.5 | 1-6 |
| 07 | `07_chomper.png` | `res://Template/plants/chomper.tscn` | 大嘴花 | Chomper | 150 | 7.5 | 1-7 |
| 08 | `08_repeaterpea.png` | `res://Template/plants/repeaterpea.tscn` | 双发射手 | Repeater | 200 | 7.5 | 1-8 |
| 09 | `09_puffshroom.png` | `res://Template/plants/puffshroom.tscn` | 小喷菇 | Puff-shroom | 0 | 2 | 1-10 |
| 10 | `10_sunshroom.png` | `res://Template/plants/sunshroom.tscn` | 阳光菇 | Sun-shroom | 25 | 7.5 | 2-1 |
| 11 | `11_fumeshroom.png` | `res://Template/plants/fumeshroom.tscn` | 大喷菇 | Fume-shroom | 75 | 7.5 | 2-2 |
| 12 | `12_gravebuster.png` | `res://Template/plants/gravebuster.tscn` | 墓碑吞噬者 | Grave Buster | 75 | 7.5 | 2-3 |
| 13 | `13_hypnoshroom.png` | `res://Template/plants/hypnoshroom.tscn` | 催眠菇 | Hypno-shroom | 75 | 30 | 2-5 |
| 14 | `14_scaredyshroom.png` | `res://Template/plants/scaredyshroom.tscn` | 胆小菇 | Scaredy-shroom | 25 | 7.5 | 2-6 |
| 15 | `15_iceshroom.png` | `res://Template/plants/iceshroom.tscn` | 寒冰菇 | Ice-shroom | 75 | 50 | 2-7 |
| 16 | `16_doomshroom.png` | `res://Template/plants/doomshroom.tscn` | 毁灭菇 | Doom-shroom | 125 | 50 | 2-8 |
| 17 | `17_lilypad.png` | `res://Template/plants/lilypad.tscn` | 荷叶 | Lily Pad | 25 | 7.5 | 2-10 |
| 18 | `18_squash.png` | `res://Template/plants/squash.tscn` | 倭瓜 | Squash | 50 | 30 | 3-1 |
| 19 | `19_threepeashooter.png` | `res://Template/plants/threepeashooter.tscn` | 三线射手 | Threepeater | 325 | 7.5 | 3-2 |
| 20 | `20_tangleklep.png` | `res://Template/plants/tangleklep.tscn` | 缠绕海草 | Tangle Kelp | 25 | 30 | 3-3 |
| 21 | `21_jalapeno.png` | `res://Template/plants/jalapeno.tscn` | 火爆辣椒 | Jalapeno | 125 | 50 | 3-5 |
| 22 | `22_spikeweed.png` | `res://Template/plants/spikeweed.tscn` | 地刺 | Spikeweed | 100 | 7.5 | 3-6 |
| 23 | `23_torchwood.png` | `res://Template/plants/torchwood.tscn` | 火炬树桩 | Torchwood | 175 | 7.5 | 3-7 |
| 24 | `24_tallnut.png` | `res://Template/plants/tallnut.tscn` | 高坚果 | Tall-nut | 125 | 30 | 3-8 |
| 25 | `25_seashroom.png` | `res://Template/plants/seashroom.tscn` | 海蘑菇 | Sea-shroom | 0 | 2 | 4-1 |
| 26 | `26_starfruit.png` | `res://Template/plants/starfruit.tscn` | 杨桃 | Starfruit | 125 | 7.5 | 4-6 |
| 27 | `27_pumpkinhead.png` | `res://Template/plants/pumpkinhead.tscn` | 南瓜头 | Pumpkin | 125 | 30 | 4-7 |
| 28 | `28_coffeebean.png` | `res://Template/plants/coffeebean.tscn` | 咖啡豆 | Coffee Bean | 75 | 7.5 | 5-3 |
| 29 | `29_garlic.png` | `res://Template/plants/garlic.tscn` | 大蒜 | Garlic | 50 | 7.5 | 5-5 |

## 特殊类（非原版冒险解锁）

出自改版《绽放与毁灭》(Bloom & Doom)，数值为参考值，请按需调整。

| id | 卡面贴图文件 | 动画场景 | 中文名 | 英文名 | 阳光花费 | 冷却时间 | 备注 |
|----|-------------|---------|--------|--------|---------|---------|------|
| S1 | `special/01_giantwallnut.png` | 暂无 | 巨型坚果 | Giant Wall-nut | 150 | 30 | 改版植物 |
| S2 | `special/02_redwallnut.png` | 暂无 | 红坚果 | Red Wall-nut (Doom Nut) | 50 | 30 | 改版原创植物 |

## 说明

- 解锁关卡中：1-x 白天、2-x 夜晚、3-x 泳池、4-x 迷雾、5-x 屋顶；空白关卡（如 1-4、1-9、2-4、2-9、3-4、3-9、4-4、4-9、5-4）奖励为铲子/图鉴/钥匙等道具或便条，非植物。
- 原版冒险解锁顺序里夹在中间、但本文件夹没有卡面的植物（如路灯花、仙人掌、三叶草、裂荚射手、磁力菇、卷心菜投手、花盆、雨伞叶等）未编号。
- 特殊类植物（S1/S2）暂无对应动画场景；`Template/plants/sun.tscn` 是阳光掉落物，不属于植物清单。
