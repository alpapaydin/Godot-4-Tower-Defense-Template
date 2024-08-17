extends Node

const turrets := {
	"gatling": {
		"stats": {
			"damage": 10,
			"attack_speed": 2.0,
			"attack_range": 1.0,
			"bulletSpeed": 200.0,
			"bulletPierce": 1,
			"rotates": true,
		},
		"cost": 50,
		"scene": "res://Scenes/turrets/turretBase.tscn",
		"sprite": "res://Assets/turrets/technoturret.png",
		"scale": 4.0,
		"bullet": "fire",
	},
	"laser": {
		"stats": {
			"damage": 0.5,
			"attack_speed": 20.0,
			"attack_range": 1.0,
			"bulletSpeed": 400.0,
			"bulletPierce": 4,
			"rotates": false,
		},
		"cost": 70,
		"scene": "res://Scenes/turrets/turretBase.tscn",
		"sprite": "res://Assets/turrets/laserturret.png",
		"scale": 1.0,
		"bullet": "laser",
	},
}

const bullets := {
	"fire": {
		"frames": "res://Assets/bullets/bullet1.tres",
	},
	"laser": {
		"frames": "res://Assets/bullets/bullet2.tres",
	}
}

const enemies := {
	"redDino": {
		"stats": {
			"hp": 10.0,
			"speed": 1.0,
			"baseDamage": 5.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Assets/enemies/dino1.png",
	},
	"blueDino": {
		"stats": {
			"hp": 5.0,
			"speed": 2.0,
			"baseDamage": 5.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Assets/enemies/dino2.png",
	},
	"yellowDino": {
		"stats": {
			"hp": 10.0,
			"speed": 5.0,
			"baseDamage": 1.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Assets/enemies/dino3.png",
	},
	"greenDino": {
		"stats": {
			"hp": 10.0,
			"speed": 10.0,
			"baseDamage": 1.0,
			"goldYield": 10.0,
			},
		"sprite": "res://Assets/enemies/dino4.png",
	}
}
