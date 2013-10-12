Slide Action Cell
===============

A UITableViewCell subclass that implements slide to action

##Usage

Import the SlideActionCell class. Inside your cellForRowAtIndexPath use the provided class methods to setup your cell.

```objc
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"Cell";
    [self.tableView registerClass:[SlideActionCell class] forCellReuseIdentifier:cellIdentifier];

    SlideActionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell){
        cell = [[SlideActionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    [cell setText:self.tableData[indexPath.row]];

    [cell addLeftAction:@"YES"
                  color:[UIColor colorWithRed:0.529 green:0.855 blue:0.318 alpha:1]
              textColor:[UIColor whiteColor]];

    [cell addRightAction:@"NO"
                   color:[UIColor colorWithRed:0.922 green:0.373 blue:0.286 alpha:1]
               textColor:[UIColor whiteColor]];

    return cell;
}
```

##Note

I started this to teach myself the concept. Please feel free to fork improve!

## Licence

MIT 





