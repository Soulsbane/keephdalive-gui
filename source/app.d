module app;

import gtk.Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import gtk.TextView;
import gtk.Entry;
import gtk.FileChooserDialog;

import gobject.Type;

import std.stdio;

class KeepAliveGui
{
	void create(string[] arguments)
	{
		Main.init(arguments);
		builder_ = new Builder();

		if(!builder_.addFromFile("keephdalivegui.glade") )
		{
			writeln("Failed to find keephdalivegui.glade file!");
		}

		mainWindow_ = cast(Window)builder_.getObject("mainWindow");

		if(mainWindow_ !is null)
		{
			mainWindow_.setTitle("Keeping Your Hard Drive Alive!");
			mainWindow_.addOnHide(delegate void(Widget aux) { Main.quit(); });

			addControls();
			mainWindow_.showAll();
		}
		else
		{
			writeln("Failed to create main window!");
		}

		Main.run();
	}

	void addControls()
	{
		pathButton_ = cast(Button)builder_.getObject("pathButton");
		pathsTextView_ = cast(TextView)builder_.getObject("pathsTextView");
		pathEditBox_ = cast(Entry)builder_.getObject("pathEditBox");
		fileChooserButton_ = cast(Button)builder_.getObject("fileChooserButton");

		pathEditBox_.setSizeRequest(485, 20);
		pathsTextView_.insertText("Blah.....\nAnotherLine\nAnd another line...");
		pathButton_.addOnClicked(&onPathButtonPressed);
		fileChooserButton_.addOnClicked(&onFileChooserButtonPressed);
	}

	void onFileChooserButtonPressed(Button button)
	{
		immutable string text = pathEditBox_.getText();

		FileChooserDialog fileChooser = new FileChooserDialog("Select the path to use", mainWindow_, FileChooserAction.SELECT_FOLDER);
		fileChooser.run();
		pathEditBox_.setText(fileChooser.getFilename());
		fileChooser.hide();
	}

	void onPathButtonPressed(Button  button)
	{
		if(pathButton_ !is null)
		{
			///Append to textview
		}
	}

private:
	Builder builder_;
	Window mainWindow_;
	Button pathButton_;
	TextView pathsTextView_;
	Entry pathEditBox_;
	Button fileChooserButton_;
}

int main(string[] arguments)
{
	auto gui = new KeepAliveGui;
	gui.create(arguments);

	return 0;
}
