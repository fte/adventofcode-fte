fn main() {
    let mut max_calories_list: Vec<u32> = Vec::new();
    let mut total_calories: u32;

    // for food in include_str!("input1a.test.txt").split("\n\n") {
    for food in include_str!("input1a.txt").split("\n\n") {
        total_calories = 0;
        for calories in food.split("\n") {
            if !calories.is_empty() {
                total_calories = total_calories + calories.parse::<u32>().unwrap();
            }
        }
        max_calories_list.push(total_calories);
    }
    max_calories_list.sort_by(|a, b| b.cmp(a));
    dbg!(max_calories_list[0] + max_calories_list[1] + max_calories_list[2]);
}
