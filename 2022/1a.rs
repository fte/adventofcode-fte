fn main() {
    let mut max_calories: u32 = 0;
    let mut total_calories: u32;

    // for food in include_str!("input1a.test.txt").split("\n\n") {
    for food in include_str!("input1a.txt").split("\n\n") {
        // dbg!(food);
        total_calories = 0;
        for calories in food.split("\n") {
            // dbg!(calories);
            if !calories.is_empty() {
                total_calories = total_calories + calories.parse::<u32>().unwrap();
            }
        }
        // println!("total_calories={total_calories}");
        if total_calories > max_calories {
            max_calories = total_calories;
        }
    }
    println!("{}", max_calories);
}
