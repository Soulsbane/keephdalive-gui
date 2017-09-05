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
		immutable string gladeFile = import("keephdalivegui.glade");

		Main.init(arguments);
		builder_ = new Builder();

		builder_.addFromString(gladeFile);
		mainWindow_ = createControl!Window("mainWindow");

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
		pathButton_ = createControl!Button("pathButton");
		pathsTextView_ = createControl!TextView("pathsTextView");
		pathEditBox_ = createControl!Entry("pathEditBox");
		fileChooserButton_ = createControl!Button("fileChooserButton");

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
	T createControl(T)(const string name)
	{
		return cast(T)builder_.getObject(name);
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
