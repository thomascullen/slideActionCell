Slide Action Cell
===============

A UITableViewCell subclass that implements slide to action

<p align="center"><img src="http://thomascullendesign.com/slide-action-cell-example.gif"/></p>


##Usage

Import the SlideActionCell class. Inside your cellForRowAtIndexPath instantiate a SlideActionCell as if it were a normal UITableViewCell.

```objc
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"Cell";
    [self.tableView registerClass:[SlideActionCell class] forCellReuseIdentifier:cellIdentifier];

    SlideActionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell){
        cell = [[SlideActionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    return cell;
}
```

Use the setText method to set the main text of the cell.

```objc
    [cell setText:self.tableData[indexPath.row]];
```

To add a slide action use any of the following class actions..

```objc
[cell addLeftActionImage:[UIImage imageNamed:@"tick"] color:[UIColor colorWithRed:0.157 green:0.761 blue:0.839 alpha:1] width:80];
```

```objc
[cell addRightActionImage:[UIImage imageNamed:@"tick"] color:[UIColor colorWithRed:0.157 green:0.761 blue:0.839 alpha:1] width:80];
```

```objc
[cell addLeftAction:@"COMPLETE"
    color:[UIColor colorWithRed:0.922 green:0.373 blue:0.286 alpha:1]
textColor:[UIColor whiteColor]
    width:100];
```

```objc
[cell addRightAction:@"DELETE"
    color:[UIColor colorWithRed:0.922 green:0.373 blue:0.286 alpha:1]
textColor:[UIColor whiteColor]
    width:100];
```

Then set the delegate of the cell using the setDelegate method
```objc
[cell setDelegate:self];
```

Finally add the optional effects

```objc
[cell addFadeEffect];
[cell addTintEffect];
```

Full Example..

```objc
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"Cell";
    [self.tableView registerClass:[SlideActionCell class] forCellReuseIdentifier:cellIdentifier];

    SlideActionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell){
        cell = [[SlideActionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    [cell setText:self.tableData[indexPath.row]];

    [cell addLeftActionImage:[UIImage imageNamed:@"tick"] color:[UIColor colorWithRed:0.157 green:0.761 blue:0.839 alpha:1] width:80];

    [cell addRightAction:@"DELETE"
                   color:[UIColor colorWithRed:0.922 green:0.373 blue:0.286 alpha:1]
               textColor:[UIColor whiteColor]
                   width:100];

    [cell setDelegate:self];

    [cell addFadeEffect];
    [cell addTintEffect];

    return cell;
}
```
##Delegate

The Delegate ( SlideActionCellDelegate ) has two required methods for when the left action is triggered and when the right action is triggered. Remember to set the delegate using setDelegate: inside cellForRowAtIndexPath

```objc
-(void)cellTriggeredLeftAction:(SlideActionCell *)cell;
-(void)cellTriggeredRightAction:(SlideActionCell *)cell;
```

##Note

I started this to teach myself the concept. If you run into any issues please log them here
https://github.com/Thomascullen92/slideActionCell/issues

## Licence

MIT 





