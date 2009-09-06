package HTML::FormHandler::Render::Hash;

use Moose::Role;

with 'HTML::FormHandler::Render::Simple' =>
   { excludes => [ 'render', 'render_field_struct', 'render_end', 'render_start' ] };

=head1 NAME

HTML::FormHandler::Render::Hash - render a form to a raw hash

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use HTML::FormHandler::Render::Hash;

    my $foo = HTML::FormHandler::Render::Hash->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Michael Nachbaur, C<< <mike at nachbaur.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-html-formhandler-render-xml at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=HTML-FormHandler-Render-Hash>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc HTML::FormHandler::Render::Hash


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=HTML-FormHandler-Render-Hash>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/HTML-FormHandler-Render-Hash>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/HTML-FormHandler-Render-Hash>

=item * Search CPAN

L<http://search.cpan.org/dist/HTML-FormHandler-Render-Hash/>

=item * Source code access

L<http://github.com/NachoMan/HTML-FormHandler-Render-Hash/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Michael Nachbaur.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of HTML::FormHandler::Render::Hash
