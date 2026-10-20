class_name ItemData extends Resource

@export var name: String
@export var id: int
@export var icon: Texture2D
@export var description: String
@export var item_type: ItemType
@export var item_rarity: ItemRarity
@export var value: int
@export var consumable: bool = false
@export var quest_item: bool = false

enum ItemType{
	EQUIPMENT,
	CONSUMABLE,
	REAGENT,
	KEY_ITEM,
	TREASURE
}

enum ItemRarity{
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
}

#Maybe use an Enum for item type and then have item type be set by extended classes.
