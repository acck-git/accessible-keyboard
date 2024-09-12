# LIAM keyboard
### Accessible Keyboard Project

<img align="right" style="width:100px; height:auto;" src="https://github.com/user-attachments/assets/c35f25f4-8944-4df3-8d29-08e1636d42cc">

A final college project written in Swift using Xcode and SwiftData.<br>
Description: an iPad app application featuring a specialized keyboard designed to teach reading using the LIAM (ליע"ם) method, tailored for children and adults with special needs and communication difficulties.<br>

> [!NOTE]
> Includes real-time auditory feedback, image-based writing exercises, and progress tracking capabilities.


<img align="right" style="width:300px; height:auto;" src="https://github.com/user-attachments/assets/e98e58d1-a962-42fa-8fd4-585ce204cfca">
<table align="center">
 <thead>
   <tr>
      <td colspan="2" align="center">Collaborators</td>
   </tr>
   </thead>
   <tbody>
    <tr>
      <td align="center"><a href="https://github.com/ElenaChes">@ElenaChes</a></td>
      <td align="center"><a href="https://github.com/RoeiHarfi">@RoeiHarfi</a></td>
      </tr>
      <td>
         <a href="https://github.com/ElenaChes"><img src="https://github.com/ElenaChes.png?size=115" width=100 /></a>
      </td>
      <td>
         <a href="https://github.com/RoeiHarfi"><img src="https://github.com/RoeiHarfi.png?size=115" width=100 /></a>
      </td>
   </tr>
   </tbody>
</table>




# Code

<details>

<summary><h3>Content</h3></summary>

- [acckp](#acckp)
  - [acckpApp.swift](#acckpappswift)
  - [Views](#views)
    - [MainView.swift](#mainviewswift)
    - [ToplineView.swift](#toplineviewswift)
    - [KeyboardView.swift](#keyboardviewswift)
    - [SettingsView.swift](#settingsviewswift)
    - [TeacherView.swift](#teacherviewswift)
    - [StatisticsView.swift](#statisticsviewswift)
    - [ImagesView.swift](#imagesviewswift)
    - [MainPresets.swift](#mainpresetsswift)
    - [SettingsPresets.swift](#settingspresetswift)
  - [Models](#models)
    - [Data.swift](#dataswift)
    - [UserData.swift](#userdataswift)
    - [ImagesData.swift](#imagesdataswift)
  - [Sounds](#sounds)
  - [Utils.swift](#utilsswift)
  - [Assets](#assets)
- [acckpTests & acckpUITests](#acckptests--acckpuitests)

</details>
<hr>

# acckp

## acckpApp.swift

App's "main", loads the DB and the app itself.

## Views

### MainView.swift

A screen selector.

- Displays the relevant screen according to `GlobalVars.screens` state.

### ToplineView.swift

Main screen's top line.

- Has the textbox and audio button.
- Displays image and confirm buttun if in image mode.

### KeyboardView.swift

Main screen's keyboard.

- Allows typing in the top line's textbox.
- Switches between vowels (nikkud) according to `GlovalVars.board`.

### SettingsView.swift

Settings screen.

- Changing logged in student.
- Selecting an image for image mode.
- Changing app's color theme.
- Logging in as a teacher.

### TeacherView.swift

Teacher's screen.

- Adding/renaming/deleting student users.
- Opening/closing boards for students.
- Access to statistics screen & to images screen.

### StatisticsView.swift

Statistics screen.

- Tables and graphs with data of student users.

### ImagesView.swift

Images screen.

- Adding new images, changing custom images' descriptions, deleting them.

> [!NOTE]
> The app has a built in database of images with set descriptions, these images can't be changed or removed by the user

### MainPresets.swift

- Components used in the main screen.

### SettingsPresets.swift

- Components used in the settings, teacher, settings and images screens.

> [!TIP] 
> `[something]View.swift` - The various screens the app has.<br> 
> `[something]Presets.swift` - The various components the app has.

## Models

### Data.swift

The backend of the app, has two classes:

- `GlobalVars` - A singleton class storing all the global variables and backend functions, such as:
  - `screen`: dictates what screen to display (main, settings, teacher, stats, images, blank).
  - `colorSet`: used color theme (0 to 3).
  - `board`: current vowel board (0 to 5).
  - `inputText`: text in the main screen's textbox.
  - `image`: currently selected image in image mode (will be displayed on the main screen top line).
  - `imageZoom`: shows the selected image on the entire screen.
- `StaticData` - Static variables that don't change throughout the app's usage, such as the letters, vowels, color codes and built in image database.

### UserData.swift

SwiftData schema for a single student user:

- `student`: user's name.
- `stats`: array of structs holding daily data such as total words typed, correct words, total letters that should've been typed and total typos for that day.
- `boards`: aray of booleans indicating which boards are open/closed for the specific user.
- `loggedIn`: whether the uses is the one currently logged in. Note: only one user can have the variable set to true at any given moment.
- `colorSet`: user's selected color theme.

### ImageData.swift

SwiftData schema for the entire custom images storage. Stores 6 arrays of image data, one per each board.

> [!NOTE]
> All the data stored in the app is local, and it can only access data of users who use the iPad it's installed on.

## Sounds

Custom recordings for the "עיצור" board (board=4), used instead of the built in AVSpeechSynthesizer.

## Utils.swift

Generic aid functions or class extensions.

## Assets

Stores the built in image database, vowels images, and app's icon.

# acckpTests & acckpUITests

App's unit and integration tests, primarily in `acckpUITests.swift`.

> [!IMPORTANT]
> To run tests the simulator has to be logged in with a user that has access to all boards, and computer's typing language has to be on English.
