[InstalledFiles::] Installed Files.

Filenames for a few unmanaged files included in a standard Inform installation.

@ Inform needs a whole pile of files to have been installed on the host computer
before it can run: everything from the Standard Rules to a PDF file explaining
what interactive fiction is. They're never written to, only read. They are
stored in subdirectories called |Miscellany| or |HTML| of the internal nest;
but they're just plain old files, and are not managed by Inbuild as "copies".

@e CBLORB_REPORT_MODEL_IRES from 1
@e DOCUMENTATION_SNIPPETS_IRES
@e INTRO_BOOKLET_IRES
@e INTRO_POSTCARD_IRES
@e LARGE_DEFAULT_COVER_ART_IRES
@e SMALL_DEFAULT_COVER_ART_IRES
@e DOCUMENTATION_XREFS_IRES
@e JAVASCRIPT_FOR_STANDARD_PAGES_IRES
@e JAVASCRIPT_FOR_EXTENSIONS_IRES
@e JAVASCRIPT_FOR_ONE_EXTENSION_IRES
@e CSS_SET_BY_PLATFORM_IRES
@e CSS_FOR_STANDARD_PAGES_IRES
@e EXTENSION_DOCUMENTATION_MODEL_IRES

=
filename *InstalledFiles::filename(int ires) {
	pathname *internal = INSTALLED_FILES_HTML_CALLBACK();
	pathname *misc = Pathnames::down(internal, I"Miscellany");
	pathname *models = Pathnames::down(internal, I"HTML");
	switch (ires) {
		case DOCUMENTATION_SNIPPETS_IRES: 
				return Filenames::in(misc, I"definitions.html");
		case INTRO_BOOKLET_IRES: 
				return Filenames::in(misc, I"IntroductionToIF.pdf");
		case INTRO_POSTCARD_IRES: 
				return Filenames::in(misc, I"Postcard.pdf");
		case LARGE_DEFAULT_COVER_ART_IRES: 
				return Filenames::in(misc, I"DefaultCover.jpg");
		case SMALL_DEFAULT_COVER_ART_IRES: 
				return Filenames::in(misc, I"Small Cover.jpg");

		case CBLORB_REPORT_MODEL_IRES: 
				return InstalledFiles::varied_by_platform(models, I"CblorbModel.html");
		case DOCUMENTATION_XREFS_IRES: 
				return InstalledFiles::varied_by_platform(models, I"xrefs.txt");
		case JAVASCRIPT_FOR_STANDARD_PAGES_IRES: 
				return InstalledFiles::varied_by_platform(models, I"main.js");
		case JAVASCRIPT_FOR_EXTENSIONS_IRES: 
				return InstalledFiles::varied_by_platform(models, I"extensions.js");
		case JAVASCRIPT_FOR_ONE_EXTENSION_IRES: 
				return InstalledFiles::varied_by_platform(models, I"extensionfile.js");
		case CSS_SET_BY_PLATFORM_IRES: 
				return InstalledFiles::varied_by_platform(models, I"platform.css");
		case CSS_FOR_STANDARD_PAGES_IRES: 
				return InstalledFiles::varied_by_platform(models, I"main.css");
		case EXTENSION_DOCUMENTATION_MODEL_IRES: 
				return InstalledFiles::varied_by_platform(models, I"extensionfile.html");
		}
	internal_error("unknown installation resource file");
	return NULL;
}

@ This enables each platform to provide its own CSS and Javascript definitions,
if they would prefer that:

=
filename *InstalledFiles::varied_by_platform(pathname *models, text_stream *leafname) {
	filename *F = NULL;
	TEMPORARY_TEXT(variation)
	WRITE_TO(variation, "%s-%S", PLATFORM_STRING, leafname);
	/* NB: PLATFORM_STRING is a C string, so that %s is correct */
	F = Filenames::in(models, variation);
	if (TextFiles::exists(F) == FALSE) F = Filenames::in(models, leafname);
	DISCARD_TEXT(variation)
	return F;
}

@ This directory also holds the |Basic.indext| and |Standard.indext| index
structure files, but in principle we allow a wider range of these to exist, so:

=
filename *InstalledFiles::index_structure_file(text_stream *leaf) {
	pathname *internal = INSTALLED_FILES_HTML_CALLBACK();
	pathname *misc = Pathnames::down(internal, I"Miscellany");
	return Filenames::in(misc, leaf);
}
