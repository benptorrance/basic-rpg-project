class_name ItemData extends Resource

@export var id: StringName = &""
@export var name: String = ""
@export var icon: Texture2D
@export var description: String = ""
@export var item_type: ItemType = ItemType.MISC
@export var item_rarity: Rarity = Rarity.COMMON
@export var max_stack_size: int = 1
@export var value: int = 0
@export var consumable: bool = false
@export var quest_item: bool = false
@export var craftable: bool = false

enum ItemType{
	EQUIPMENT,
	CONSUMABLE,
	REAGENT,
	KEY_ITEM,
	TREASURE,
	MISC
}

enum Rarity{
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
}

#Maybe use an Enum for item type and then have item type be set by extended classes.
