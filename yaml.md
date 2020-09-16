# YAML files


Example:
```yaml
servers:
    - name: Server 1
      owner: John
      status: active
    - name: Server 2
      owner: Jack
      status: active
    
```


 Key value par:
```yaml
Fruit: Apple
Vegetable: Carrot
Liquid: Water
Meat: Chicken
```


Array/lists
```yaml
Fruits:
-   Orange
-   Apple
-   Banana

Vegetables:
-   Carrot
-   Cauliflower
-   Tomato

```
"-" are for lists on YAML.

Dictionary/Map
```yaml
Banana:
    Calories: 105
    Fat: 0.4 g
    Carbs: 27 g

Grapes
    Calories: 62
    Fat: 0.3 g
    Carbs: 16 g
```


An advanced example:
```yaml
# Hello I am a comment
Fruits:
    - Banana:
        Calories: 105
        Fat: 0.4 g
        # Other comment? yes it is valid
        Carbs: 27 g
        
    - Grapes
        Calories: 62
        Fat: 0.3 g
        Carbs: 16 g
```
